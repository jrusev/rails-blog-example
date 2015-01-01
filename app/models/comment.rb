# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  commenter  :string
#  body       :text
#  article_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to :article
end
