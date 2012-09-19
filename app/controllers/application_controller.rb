class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def require_login
    if current_user.nil?
      redirect_to login_path
    end
  end

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def authorized?(user)
    current_user.id == user.id || current_user.name == "admin"
  end
  helper_method :authorized?

  def redis_create(type, id)
    @users = User.where('id != ?', current_user.id)
    $redis.multi do  
      @users.each do |user|
        $redis.sadd("user:#{user.id}:#{type}", id)
      end
    end
  end

  def redis_expire(type)
    $redis.expire("user:#{current_user.id}:#{type}", 2)
  end

  def redis_rem(type, id)
    $redis.srem("user:#{current_user.id}:#{type}", id)
  end

  def redis_rem_all(type, id)
    @users = User.where('id != ?', current_user.id)
    $redis.multi do  
      @users.each do |user|
        $redis.srem("user:#{user.id}:#{type}", id)
      end
    end
  end

  def redis_del(type)
    $redis.del("user:#{current_user.id}:#{type}")
  end

  def redis_del_all(type)
    @users = User.where('id != ?', current_user.id)
    $redis.multi do  
      @users.each do |user|
        $redis.del("user:#{user.id}:#{type}")
      end
    end
  end

end
