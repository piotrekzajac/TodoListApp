require "spec_helper"

describe "Creating todo lists" do 
	def create_todo_list(options={})
		options[:title] ||= "My Todo list"
		options[:description] ||= "This is my todo list." 

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"
	end

	it "redirects to the todo list index page on success" do 
		create_todo_list
		expect(page).to have_content("My Todo list")
	end

	it "displays an error when todo list have no title" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I am doing today.")
	end

	it "displays an error when todo list have title less than 3 characters" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: "Hi"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I am doing today.")
	end

	it "displays an error when todo list have no description" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: "Grocery list", description: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Grocery list")
	end

	it "displays an error when todo list have description less than 10 characters" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: "Grocery list", description: "Carrot"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Grocery list")
	end
end