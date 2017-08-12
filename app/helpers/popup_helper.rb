module PopupHelper
  def open_popup(title: 'Message', partial: '', locals: {})
    render partial: 'popups/popup', locals: { title: title, render_path: partial, locals: locals }
  end

  def open_confirm(title: 'Message', partial: '', locals: {})
    render partial: 'popups/confirm', locals: { title: title, render_path: partial, locals: locals }
  end

  def open_message(flash, title: 'Message')
    messages = []

    flash.each do |type, message|
      messages << message
    end

    render partial: 'popups/message', locals: { title: title, message: messages.join("<br />").html_safe }, formats: :js if messages.any?
  end
end
