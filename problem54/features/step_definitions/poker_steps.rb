Given(/^a hand with the following cards:$/) do |table|
  # table is a Cucumber::Ast::Table
  @hand = Hand.new(table)
end
