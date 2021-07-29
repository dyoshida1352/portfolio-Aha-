class Users::SearchsController < ApplicationController

  def search
    @model = params["search"]["model"]
    @value = params["search"]["value"]
    @how = params["search"]["how"]
    @datas = search_for(@how, @model, @value)
  end


  private

  def partical(model, value)
    if model == 'post'
      Post.where("post_name LIKE ?", "%#{value}%")
    elsif model == 'tag'
      # Post.joins(:tag_relationships, :tags).where("tags.tag_name LIKE ?", "%#{value}%" ) 複数個のタグ検索機能 ※要修正
      Tag.find_by("tag_name LIKE ?", "%#{value}%").posts
    elsif model == 'invite'
      Invite.where("invite_name LIKE ?", "%#{value}%")
    elsif model == 'invite_tag'
      # Invite.(:invite_tag_relationships, :invite_tags).where("invite_tags.invite_tag_name LIKE ?", "%#{value}%" ) 複数個のタグ検索機能 ※要修正
      InviteTag.find_by("invite_tag_name LIKE ?",  "%#{value}%").invites
    end
  end

  def search_for(how, model, value)
    partical(model, value)
  end

end
