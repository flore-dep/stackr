class PagesController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def home
    costs_per_month
    active_licenses_per_month
    tools_by_category
  end

  private

  def tools_per_team_per_month
    start_date = 1.year.ago
    teams = Team.all

    @chart_data = teams.map do |team|
      {
        name: team.name,
        data: team.tools.group_by_month(:created_at, range: start_date..Time.now).count
      }
    end
    Rails.logger.debug "Tools per team per month data: #{@chart_data.inspect}"
  end

  def costs_per_month
    tab = []
    Team.all.each do |team|
      (1..12).each do |m|
        date = Time.new(2025, m, 1)
        licenses = team.licenses.where("start_date <= ? AND end_date > ?", date, date)
        cost = 0
        licenses.each do |l|
          cost += l.plan.formula[1]
        end
        obj = {:name => team.name, :data => { date => cost}}
        tab.push(obj)
      end
    end

    cd = tab
    # cd = [
    #   {:name=>"MR", :data=>{"Sun, 01 Jan 2017"=>44}},
    #   {:name=>"CT", :data=>{"Sun, 01 Jan 2017"=>7}},
    #   {:name=>"US", :data=>{"Sun, 01 Jan 2017"=>1}},
    #   {:name=>"MR", :data=>{"Wed, 01 Feb 2017"=>41}},
    #   {:name=>"CT", :data=>{"Wed, 01 Feb 2017"=>4}},
    #   {:name=>"CT", :data=>{"Wed, 01 Mar 2017"=>6}},
    #   {:name=>"XR", :data=>{"Wed, 01 Mar 2017"=>1}},
    #   {:name=>"US", :data=>{"Sat, 01 Apr 2017"=>1}}
    #   ]
    cost = cd.each_with_object({}) do |g,h|
      h.update(g[:name]=>g) { |_,n,o| { name: n[:name], data: n[:data].merge(o[:data]) } }
    end
    @cost_data = cost.values
  end

  def active_licenses_per_month
    start_date = 1.year.ago
    @license_data = License.where(status: "Approved").group_by_month(:start_date, range: start_date..Time.now).count
    Rails.logger.debug "Active licenses per month data: #{@license_data.inspect}"
  end

  def tools_by_category
    @category_data = Tool.group(:category).count
    Rails.logger.debug "Tools by category data: #{@category_data.inspect}"
  end
end
