# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: 'admin@example.com',
  password: 'admin1'
)

User.create!(
  [
    {
      name: 'アオイ',
      email: 'Test1@test.com',
      password: '111111',
      profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("db/fixtures/man-geed575553_640.jpg"),filename: "man-geed575553_640.jpg")
    },
    {
      name: 'アカネ',
      email: 'Test2@test.com',
      password: '111111',
      profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("db/fixtures/woman-g4b15ed6de_640.jpg"),filename: "woman-g4b15ed6de_640.jpg")
    },
    {
      name: 'バイオリン大好き',
      email: 'Test3@test.com',
      password: '111111',
      profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("db/fixtures/adventure-g666090654_640.jpg"),filename: "adventure-g666090654_640.jpg")
    },
  ]
 )

List.create!(
  [
    {
      name: '蝶',
      introduction:
        %Q{ベランダにやってきたカバマダラの仲間かなと思います。\n},
      habitat: "東京都荒川区",
      user_id: 1,
      image: ActiveStorage::Blob.create_and_upload!(io: File.open("db/fixtures/butterfly-354528_640.jpg"),filename: "butterfly-354528_640.jpg")
    },
    {
      name: '美しい蝶',
      introduction:
        %Q{花とのコントラストが美しかったので思わず、写真を撮りました。\n蝶の名前は不明},
      habitat: "東京都練馬区",
      user_id: 1,
      image: ActiveStorage::Blob.create_and_upload!(io: File.open("db/fixtures/butterfly-gba394e264_640.jpg"),filename: "butterfly-gba394e264_640.jpg")
    },
    {
      name: '美しいトンボ',
      introduction:
        %Q{珍しいトンボをみかけました。\n蝶の名前は不明},
      habitat: "東京都練馬区",
      user_id: 2,
      image: ActiveStorage::Blob.create_and_upload!(io: File.open("db/fixtures/dragonfly-g2d002fa95_640.jpg"),filename: "dragonfly-g2d002fa95_640.jpg")
    },
    {
      name: '美しいトンボ２',
      introduction:
        %Q{珍しいトンボをみかけました。\nこのトンボの名前など詳しい方、どなたかご存知の方、ご教示ください。},
      habitat: "東京都",
      user_id: 2,
      image: ActiveStorage::Blob.create_and_upload!(io: File.open("db/fixtures/dragon-fly-g86e17fb4b_640.jpg"),filename: "dragon-fly-g86e17fb4b_640.jpg")
    },
    {
      name: 'ミヤマクワガタ',
      introduction:
        %Q{おそらくミヤマクワガタと思われます。},
      habitat: "東京都文京区",
      user_id: 3,
      image: ActiveStorage::Blob.create_and_upload!(io: File.open("db/fixtures/stag-beetle-g40e62933c_640.jpg"),filename: "stag-beetle-g40e62933c_640.jpg")
    },
    {
      name: '蜂',
      introduction:
        %Q{ミツバチでしょうか。お花見中に見つけました。},
      habitat: "福岡市博多区",
      user_id: 3,
      image: ActiveStorage::Blob.create_and_upload!(io: File.open("db/fixtures/bee-g631ef3f63_640.jpg"),filename: "bee-g631ef3f63_640.jpg")
    },
  ]
)