require "csv"
require "caxlsx"  # Make sure to require caxlsx

class ExportFormatService
  def initialize(records, attributes, title = nil)
    @records = records
    @attributes = attributes
    @title = title
  end

  def generate_csv
    CSV.generate(headers: true) do |csv|
      csv << [ @title ].flatten if @title.present?
      csv << @attributes.map(&:humanize)

      @records.each do |record|
        csv << @attributes.map { |attr| formatted_value(record, attr) }
      end
    end
  end

  def generate_xlsx
    package = Axlsx::Package.new
    workbook = package.workbook

    workbook.add_worksheet(name: @title.is_a?(Array) ? @title.first : "Sheet1") do |sheet|
      sheet.add_row [ @title ].flatten if @title.present?
      sheet.add_row @attributes.map(&:humanize)

      @records.each do |record|
        sheet.add_row @attributes.map { |attr| formatted_value(record, attr) }
      end
    end

    package.to_stream.read
  end

  private

  def client_name(record)
   if record.respond_to?(:issued_to) && record.issued_to.present?
     record.issued_to.name
   elsif record.respond_to?(:client) && record.client.present?
     record.client.name
   else
     "No client"
   end
  end

  def formatted_value(record, attr_path)
   if record.is_a?(Hash)
     key = attr_path.downcase.underscore.to_sym
     return record[key].presence || "No data"
   end

   value = custom_value_logic(record, attr_path)

    case value
    when ActiveRecord::Associations::CollectionProxy then value.pluck(:name).join(", ")
    when ActiveRecord::Base then value&.name
    else value.presence || "No data"
    end
  end

  def custom_value_logic(record, attr_path)
    case attr_path
    when "client_name" then client_name(record)
    when "task_name" then record&.title
    when "case" then record&.court_case&.title
    when "assigned_to" then record&.assignee
    when "invoice_no" then record&.invoice_number
    when "issued_date" then record&.issued_at
    when "status" then record&.status
    when "due_date" then record&.due_date
    when "no" then record&.id
    when "lawyer" then record&.lawyer&.name
    when "total" then ""
    when "paid" then ""



    else
      attr_path.split(".").reduce(record) { |obj, method| obj&.send(method) }
    end
  end
end
