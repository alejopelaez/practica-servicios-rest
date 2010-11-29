class BaseController
  def self.render(that, format)
    case format
    when 'json'
      that.to_json
    when 'xml'
      that.to_xml
    end
  end
end
