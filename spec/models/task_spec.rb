# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '`title`のバリデーションをテスト' do
    let(:task) { build(:task, title: title) }

    context '`title`が100文字の場合、有効' do
      let(:title) { 'A' * 100 }
      it do
        expect(task).to be_valid
      end
    end

    context '`title`が101文字の場合、無効' do
      let(:title) { 'A' * 101 }
      it do
        expect(task).to_not be_valid
        expect(task.errors.full_messages).to match_array('Title is too long (maximum is 100 characters)')
      end
    end

    context '`title`が0文字の場合、無効' do
      let(:title) { 'A' * 0 }
      it do
        expect(task).to_not be_valid
        expect(task.errors.full_messages).to match_array("Title can't be blank")
      end
    end

    context '`title`が空白のみの場合、無効' do
      let(:title) { '' }
      it do
        expect(task).to_not be_valid
        expect(task.errors.full_messages).to match_array("Title can't be blank")
      end
    end
  end

  describe '`description`のバリデーションをテスト' do
    it '`description`が1000文字の場合、有効'
    it '`description`が1001文字の場合、無効'
    it '`description`が0文字の場合、有効'
  end

  describe '`status`のバリデーションをテスト' do
    it '`status`が10文字の場合、有効'
    it '`status`が11文字の場合、無効'
    it '`status`が0文字の場合、無効'
    it '`status`が空白のみの場合、無効'
  end

  describe '`priority`のバリデーションをテスト' do
    it '`priority`が10文字の場合、有効'
    it '`priority`が11文字の場合、無効'
    it '`priority`が0文字の場合、有効'
  end

  describe '`deadline`のバリデーションをテスト' do
    it '`deadline`が`2023-01-01 17:28:00 UT`の場合、有効'
    it '`deadline`が`2023-01-01 17:28:00 UT`でない場合、無効'
  end
end
