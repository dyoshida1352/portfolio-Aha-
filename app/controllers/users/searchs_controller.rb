class Users::SearchsController < ApplicationController

  def search
    @model = params["search"]["model"]
    @value = params["search"]["value"]
    @how = params["search"]["how"]
    @datas = search_for(@how, @model, @value)
  end


  private

  def match(model, value)
    if model == 'post'
      Post.where(post_name: value)
    elsif model == 'invite'
      Invite.where(invite_name: value)
    end
  end

  def forward(model, value)
    if model == 'post'
      Post.where("post_name LIKE ?", "#{value}%")
    elsif model == 'invite'
      Invite.where("invite_name LIKE ?", "#{value}%")
    end
  end

  def backward(model, value)
    if model == 'post'
      Post.where("post_name LIKE ?", "%#{value}")
    elsif model == 'invite'
      Invite.where("invite_name LIKE ?", "%#{value}")
    end
  end

  def partical(model, value)
    if model == 'post'
      Post.where("post_name LIKE ?", "%#{value}%")
    elsif model == 'invite'
      Invite.where("invite_name LIKE ?", "%#{value}%")
    end
  end

  def search_for(how, model, value)
    case how
    when 'match'
      match(model, value)
    when 'forward'
      forward(model, value)
    when 'backward'
      backward(model, value)
    when 'partical'
      partical(model, value)
    end
  end

end
