#encoding: utf-8
class BaseData
  class << self
    def user_data
      %Q{
            name            | email  | avator
            Vik             | 1@g.cn | http://images.dunkhome.com/user/avator/904235/thumb_0.jpeg
            Shirley         | 2@g.cn | http://images.dunkhome.com/user/avator/371643/thumb_100.png
            Linda           | 3@g.cn | http://images.dunkhome.com/user/avator/893244/thumb_0.jpeg
            Mary            | 4@g.cn | http://images.dunkhome.com/user/avator/919473/thumb_0.jpeg
            Judy            | 5@g.cn | http://images.dunkhome.com/user/avator/877889/thumb_1503075757-upload-image.png
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

    def todo_list_data
      %Q{
            name       | project      | creator
            产品原型   | dunkhome     | Vik
            UI设计     | dunkhome     | Vik
            后台开发   | dunkhome     | Vik
            前端开发   | dunkhome     | Vik
            安卓开发   | sindex       | Shirley
            ios开发    | sindex       | Shirley
            bug测试    | sindex       | Shirley
            安卓开发   | get          | Linda
            ios开发    | get          | Linda
            bug测试    | get          | Linda
      }
    end

    def todo_data
      %Q{
            title            | todo_list  | project  | creator
            产品原型task1    | 产品原型   | dunkhome | Vik
            产品原型task2    | 产品原型   | dunkhome | Vik
            产品原型task3    | 产品原型   | dunkhome | Vik
            产品原型task4    | 产品原型   | dunkhome | Vik
            安卓开发task1    | 安卓开发   | sindex   | Shirley
            安卓开发task2    | 安卓开发   | sindex   | Shirley
            安卓开发task3    | 安卓开发   | sindex   | Shirley
            安卓开发task4    | 安卓开发   | sindex   | Shirley
            ios开发task1     | ios开发    | get      | Linda
            ios开发task2     | ios开发    | get      | Linda
            ios开发task3     | ios开发    | get      | Linda
            ios开发task4     | ios开发    | get      | Linda
            ios开发task5     | ios开发    | get      | Linda
            ios开发task6     | ios开发    | get      | Linda
            ios开发task7     | ios开发    | get      | Linda
            ios开发task8     | ios开发    | get      | Linda
            ios开发task9     | ios开发    | get      | Linda
            ios开发task10    | ios开发    | get      | Linda
            ios开发task11    | ios开发    | get      | Linda
            ios开发task12    | ios开发    | get      | Linda
            ios开发task13    | ios开发    | get      | Linda
            ios开发task14    | ios开发    | get      | Linda
            ios开发task15    | ios开发    | get      | Linda
            ios开发task16    | ios开发    | get      | Linda
            ios开发task17    | ios开发    | get      | Linda
            ios开发task18    | ios开发    | get      | Linda
            ios开发task19    | ios开发    | get      | Linda
            ios开发task20    | ios开发    | get      | Linda
      }
    end

    def todo_change_data
      %Q{
            title            | modify_column  | column_value  | creator
            产品原型task1    | status         | 1             | Vik
            产品原型task1    | status         | 2             | Vik
            产品原型task2    | status         | 1             | Shirley
            产品原型task2    | status         | 0             | Shirley
            产品原型task2    | deleted_at     | 2017-09-21    | Linda
            产品原型task2    | deleted_at     |               | Linda
            安卓开发task3    | assign_user_id | 1             | Shirley
            安卓开发task3    | assign_user_id | 2             | Mary
            安卓开发task3    | expire_date    | 2017-09-24    | Mary
            安卓开发task3    | expire_date    | 2017-09-28    | Judy
            安卓开发task4    | expire_date    | 2017-09-23    | Judy
            安卓开发task4    | expire_date    | 2017-09-25    | Judy
            安卓开发task4    | expire_date    | 2017-09-29    | Judy
            安卓开发task4    | expire_date    | 2017-10-01    | Judy
            产品原型task3    | status         | 1             | Vik
            产品原型task3    | status         | 2             | Vik
            产品原型task3    | status         | 1             | Shirley
            产品原型task4    | status         | 0             | Shirley
            产品原型task4    | deleted_at     | 2017-09-21    | Linda
            产品原型task4    | deleted_at     |               | Linda
      }
    end

    def todo_comment_data
      %Q{
            todo             | content          | creator | deleted_at
            产品原型task1    | 这个想法不错哒   |  Mary   |
            产品原型task2    | wawawawa nice    |  Judy   |
            产品原型task3    | balabalabala     |  Linda  |
            产品原型task4    | 怎么说呢....     |  Vik    | 2017-09-21
            产品原型task1    | 这个想法不错哒   |  Mary   |
            产品原型task2    | wawawawa nice    |  Judy   |
            产品原型task3    | balabalabala     |  Linda  |
            产品原型task4    | 怎么说呢....     |  Vik    | 2017-09-21
            产品原型task1    | 这个想法不错哒   |  Mary   |
            产品原型task2    | wawawawa nice    |  Judy   |
            产品原型task3    | balabalabala     |  Linda  |
            产品原型task4    | 怎么说呢....     |  Vik    | 2017-09-21
            产品原型task1    | 这个想法不错哒   |  Mary   |
            产品原型task2    | wawawawa nice    |  Judy   |
            产品原型task3    | balabalabala     |  Linda  |
            产品原型task4    | 怎么说呢....     |  Vik    | 2017-09-21
            产品原型task1    | 这个想法不错哒   |  Mary   |
            产品原型task2    | wawawawa nice    |  Judy   |
            产品原型task3    | balabalabala     |  Linda  |
            产品原型task4    | 怎么说呢....     |  Vik    | 2017-09-21
            产品原型task1    | 这个想法不错哒   |  Mary   |
            产品原型task2    | wawawawa nice    |  Judy   |
            产品原型task3    | balabalabala     |  Linda  |
            产品原型task4    | 怎么说呢....     |  Vik    | 2017-09-21
            产品原型task1    | 这个想法不错哒   |  Mary   |
            产品原型task2    | wawawawa nice    |  Judy   |
            产品原型task3    | balabalabala     |  Linda  |
            产品原型task4    | 怎么说呢....     |  Vik    | 2017-09-21
            产品原型task1    | 这个想法不错哒   |  Mary   |
            产品原型task2    | wawawawa nice    |  Judy   |
            产品原型task3    | balabalabala     |  Linda  |
            产品原型task4    | 怎么说呢....     |  Vik    | 2017-09-21
            产品原型task1    | 这个想法不错哒   |  Mary   |
            产品原型task2    | wawawawa nice    |  Judy   |
            产品原型task3    | balabalabala     |  Linda  |
            产品原型task4    | 怎么说呢....     |  Vik    | 2017-09-21
            产品原型task1    | 这个想法不错哒   |  Mary   |
            产品原型task2    | wawawawa nice    |  Judy   |
            产品原型task3    | balabalabala     |  Linda  |
            产品原型task4    | 怎么说呢....     |  Vik    | 2017-09-21
      }
    end
  end
end


