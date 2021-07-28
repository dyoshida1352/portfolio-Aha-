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
      Post.joins(:tag_relationships, :tags).where("tags.tag_name like ?", "%#{value}%" )
    elsif model == 'invite'
      Invite.where("invite_name LIKE ?", "%#{value}%")
    elsif model == 'invite_tag'
      Invite.joins(:invite_tag_relationships, :invite_tags).where("invite_tags.invite_tag_name like ?", "%#{value}%" )
    end
  end

  def search_for(how, model, value)
    partical(model, value)
  end

end
