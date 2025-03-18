class LicensesController < ApplicationController
  def create
    @license = License.new
  end

  def accept
    @license = License.find(params[:id])
    @license.update(status: "Approved")
  end

  def reject
    @license = License.find(params[:id])
    @license.update(status: "Declined")
  end
end
