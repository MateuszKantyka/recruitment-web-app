class InterestsQuery
  def self.call
    new.call
  end

  def call
    search_interest
  end

  private

  def search_women_age_20_30
    User.where(is_male: false)
        .where(birthday: Date.current-30.year..Date.current-20.year)
  end

  def search_interest
    Interest.where(user: search_women_age_20_30, type:'health')
            .where('name like ?', 'cosm%').count
  end
end
