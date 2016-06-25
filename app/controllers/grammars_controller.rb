class GrammarsController < ApplicationController
  before_action :parse_input, only: :new

  def index; end

  def new
    render text: GrammarChecker.new(@grammar).check
  end

private
  def parse_input
    @grammar = params[:grammar].split("\n").map(&:strip)
  end
end
