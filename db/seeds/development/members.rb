names = ['Taro', 'Jiro', 'Hana', 'John', 'Mike', 'Sophy', 'Bill', 'Alex', 'Mary', 'Tom', 'Joe', 'Smith']
fnames = ["佐藤", "鈴木", "高橋", "田中", '山田', '山本']
gnames = ["太郎", "次郎", "花子", '一郎', '和子', '三郎']
0.upto(11) do |idx|
  Member.create(
    number: idx + 10,
    name: names[idx],
    full_name: "#{fnames[idx % 4]} #{gnames[idx % 3]}",
    email: "#{names[idx]}@example.com",
    birthday: "1981-12-01",
    sex: [1, 1, 2][idx % 3],
    prefecture_id: rand(1..47),
    administrator: (idx == 0),
    password: "12345678",
    password_confirmation: "12345678"
  )
end
