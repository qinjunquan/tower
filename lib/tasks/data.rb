#encoding: utf-8
class BaseData
  class << self
    def user_data
      %Q{
            name            | email
            Vik             | 1@g.cn
            Shirley         | 2@g.cn
            Linda           | 3@g.cn
            Mary            | 4@g.cn
            Judy            | 5@g.cn
      }
    end

    def team_data
      %Q{
            name            | creator | members
            杭州当客        | Vik     | Vik,Shirley,Linda,Mary,Judy
            灌篮之家        | Vik     | Vik,Shirley,Linda
      }
    end

    def project_data
      %Q{
            name       | team         | creator | members
            dunkhome   | 杭州当客     | Vik     | Vik,Shirley,Linda,Mary,Judy
            sindex     | 杭州当客     | Vik     | Vik,Shirley,Linda,Mary
            get        | 杭州当客     | Vik     | Vik,Shirley,Linda
      }
    end
  end
end


