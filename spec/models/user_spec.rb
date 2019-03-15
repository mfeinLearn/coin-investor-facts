require 'pry'
describe 'User' do # describe - wrape and enclose the various test for our various models
  #1. describe the attributes of a user
  #2. the string '' is ->'use string to describe this paticular test'
  before do
    @user = User.create(:username => "test 123", :email => "test123@aol.com", :password => "test")
  end

  #1. describe the attributes of a user
  #2. the string '' is ->'use string to describe this paticular test'
  it 'has a username, email, and password' do
    user = User.create(username: "Malcome", email: "mfein90@gmail.com", password: "password")

    expect(user).to be_valid
  end

  it 'is invalid without a username'  do
    user = User.create(email: "mfein90@gmail.com", password: "password")

    expect(user).to_not be_valid
  end

  it 'is invalid without a email' do
    user = User.create(username: "Malcome", password: "password")

    expect(user).to_not be_valid
  end

  it 'is invalid without an password' do
    user = User.create(username: "Malcome", email: "mfein90@gmail.com")

    expect(user).to_not be_valid
  end

  it 'is invalid with a duplicate email' do
  user1 = User.create(username: "Malcome", email: "mfein90@gmail.com", password: "password")
  user2 = User.create(username: "Philip",  email: "mfein90@gmail.com", password: "password_code")

  expect(user2).to_not be_valid
  end

  it 'can slug the username' do
    expect(@user.slug).to eq("test-123")
  end

  it 'can find a user based on the slug' do
    slug = @user.slug
    expect(User.find_by_slug(slug).username).to eq("test 123")
  end

  it 'has a secure password' do

    expect(@user.authenticate("dog")).to eq(false)

    expect(@user.authenticate("test")).to eq(@user)
  end
end
