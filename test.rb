require 'tooling'

client = Tooling::Client.new(session_id: "00Do0000000Kcya!ARAAQG5Q9Q_328izVO93gZx8Xqoy7AYXd_ocAO5xkaKgUxs0Fir_cAwp8r9Mj2kQS2BuVCwheKwmdTo5WwUupdlo.ZzBLoEn")

response = client.request(sobject: 'RecordType')

puts response.body
