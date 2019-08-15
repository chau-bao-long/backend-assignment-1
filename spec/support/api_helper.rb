module ApiHelper
  def res_body
    JSON.parse(response.body)
  end

  def expect_code code
    expect(response.status).to eq code
  end
end
