module ApplicationHelper
  def status_badge(status)
    case status&.downcase
    when "open"
      content_tag(:span, status.capitalize, class: "badge rounded-pill bg-success")
    when "closed"
      content_tag(:span, status.capitalize, class: "badge rounded-pill bg-danger")
    when "pending"
      content_tag(:span, status.capitalize, class: "badge rounded-pill bg-warning text-dark")
    else
      content_tag(:span, status.capitalize, class: "badge rounded-pill bg-secondary")
    end
  end

  def get_task_status(status)
    case status&.downcase
    when "completed"
      content_tag(:span, status.capitalize, class: "badge rounded-pill bg-success")
    when "in_progress"
      content_tag(:span, status.humanize, class: "badge rounded-pill bg-info text-dark")
    when "pending"
      content_tag(:span, status.capitalize, class: "badge rounded-pill bg-warning text-dark")
    end
  end

  def priority_badge(priority)
    case priority&.downcase
    when "low"
      content_tag(:span, priority.capitalize, class: "badge rounded-pill bg-secondary")
    when "normal"
      content_tag(:span, priority.capitalize, class: "badge rounded-pill bg-info text-dark")
    when "high"
      content_tag(:span, priority.capitalize, class: "badge rounded-pill bg-primary")
    when "urgent"
      content_tag(:span, priority.capitalize, class: "badge rounded-pill bg-warning text-dark")
    when "critical"
      content_tag(:span, priority.capitalize, class: "badge rounded-pill bg-danger")
    when "immediate"
      content_tag(:span, priority.capitalize, class: "badge rounded-pill bg-dark")
    else
      content_tag(:span, priority.to_s.capitalize, class: "badge rounded-pill bg-light text-dark")
    end
  end
end
