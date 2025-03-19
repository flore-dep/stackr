class PagesController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def home
    tools_per_team_per_month
    costs_per_team_per_month
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
  end

  def costs_per_team_per_month
    start_date = 1.year.ago
    @cost_data = Team.all.map do |team|
      {
        name: team.name,
        data: team.tools.joins(:plans)
                  .group_by_month(:created_at, range: start_date..Time.now)
                  .sum("COALESCE((plans.formula->'business'->>1)::numeric, 0)")
      }
    end
    # raise
  end


  def active_licenses_per_month
    start_date = 1.year.ago
    @license_data = License.where(status: "Approved").group_by_month(:start_date, range: start_date..Time.now).count
  end

  def tools_by_category
    @category_data = Tool.group(:category).count
  end
end
