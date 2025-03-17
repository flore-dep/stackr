class LicensesController < ApplicationController
  def create
    @license = License.new
  end
end
