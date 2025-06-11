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

  def formatted_value(record, attr)
    case attr.to_s
    when "client_name"
      record.client&.name || "No data"
    else
      value = record.public_send(attr)
      if value.is_a?(Time) || value.is_a?(Date)
        value.strftime("%Y-%m-%d")
      else
        value
      end
    end
  end
end
