module ApiHelper
  def res_body
    JSON.parse(response.body)
  end
end
