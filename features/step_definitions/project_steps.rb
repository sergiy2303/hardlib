When /^I am trying to create (project|chapter|part):$/ do |item, table|
  click_link("New #{item}")
  table.hashes.each do |row|
    row.each do |key, value|
      fill_in(key, with: value)
    end
  end
  click_button("Create #{item.capitalize}")
end

When /^I follow to projects page$/ do
  step %{I press link "Account"}
  step %{I press link "My projects"}
end
