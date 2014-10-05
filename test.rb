require 'tooling'

client = Tooling::Client.new(session_id: "00Do0000000Kcya!ARAAQDTeloOcdNgVg_mMEQCkebqgAdBldWtWjBlU8M5TvdV6CkLb.ptuMIWywqWeS0mLjgRoJF58JwxgM6jCGUT8C2r1f8oI")

client.request(sobject: 'RecordType')
