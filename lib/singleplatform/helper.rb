module Singleplatform

  def params_blank?(*args)
    args.map { |a| return true if a.nil? || a.to_s.gsub(/\s/, '').empty? }
    false
  end

end