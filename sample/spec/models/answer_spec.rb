require 'rails_helper'

RSpec.describe QuestionMod::Answer, type: :model do
  describe "创建用户1，用户2" do
    before{
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @question1 = FactoryGirl.create(:question, :creator => @user1)
    }

    it "回答字段完全通过校验" do
      answer1 = FactoryGirl.create(:answer, :creator => @user2, :question => @question1)
      expect(answer1).to be_valid
    end

    describe "用户2对用户1创建的问题1创建回答" do
      before{
        @user2.answers.create(:content => "123", :question => @question1)
      }

      it{
        expect(@question1.answered).to eq(true)
      }
    end

    it "用户不能给自己的 question 增加 answer" do
      expect{
        FactoryGirl.create(:answer, :creator => @user1, :question => @question1)
      }.to raise_error(Mongoid::Errors::Validations)
    end

    describe "测试用户2对回答1进行修改成功" do
      before{
        @answer1 = @user2.answers.create(:content => "123", :question => @question1)
        @answer1.update(:content => "sb")
      }
      it "修改成功" do
        expect(@answer1.content).to eq("sb")
      end
    end
  end
end
