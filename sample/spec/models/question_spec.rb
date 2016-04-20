require 'rails_helper'

RSpec.describe QuestionMod::Question, type: :model do
  describe "创建用户1" do
    before{
      @user1 = FactoryGirl.create(:user)
    }

    it "测试问题字段完全通过校验" do
      question = @user1.created_questions.create(:title => "hgh", :content => "dgfg")
      expect(question).to be_valid
    end

    it "测试创建问题成功" do
      expect{
        @user1.created_questions.create(:title => "hgh", :content => "dgfg")
      }.to change{@user1.created_questions.count}.by(1)
    end
  end
end
