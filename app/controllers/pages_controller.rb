class PagesController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def home
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
    Rails.logger.debug "Tools per team per month data: #{@chart_data.inspect}"
  end

  def costs_per_team_per_month
    start_date = 1.year.ago
    @cost_data = Team.all.map do |team|
      monthly_costs = team.tools
                          .where("tools.created_at >= ? AND tools.created_at <= ?", start_date, Time.now)
                          .group_by { |tool| tool.created_at.beginning_of_month }
                          .transform_values { |tools| tools.sum { |tool| tool_cost(tool) } }
      {
        name: team.name,
        data: monthly_costs
      }
    end
    Rails.logger.debug "Costs per team per month data: #{@cost_data.inspect}"
  end

  def tool_cost(tool)
    plan = tool.plans.first
    return 0.0 unless plan

    formula = plan.formula.is_a?(String) ? JSON.parse(plan.formula) : plan.formula
    formula = formula.first if formula.is_a?(Array)
    key = determine_key(formula)
    formula[key].to_f
  rescue JSON::ParserError => e
    Rails.logger.error "Error parsing formula for plan #{plan.id}: #{e.message}"
    0.0
  end

  def determine_key(formula)
    formula_keys = formula.is_a?(Hash) ? formula.keys : []
    # Determine the key based on your business logic
    # For example, if you want to prioritize 'business' over 'enterprise' and 'free'
    if formula_keys.include?('business')
      'business'
    elsif formula_keys.include?('enterprise')
      'enterprise'
    else
      'free'
    end
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
