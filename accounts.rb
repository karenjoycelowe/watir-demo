#-------------------------------------------------------------#
# Sample test for the Recurly UI
#
# Purpose: to verify that a Recurly user can:
#   * log in to the Recurly UI,
#   * navigate to the Accounts page,
#   * view the accounts for the Recurly subdomain.
#-------------------------------------------------------------#

# the Watir Ruby gem enables Web Application Testing in Ruby
require 'watir-webdriver'

# set some variables for our login credentials
test_site = 'https://app.recurly.com/login'
test_subdomain = 'karentobo'
test_email = 'kjtobo@gmail.com'
test_password = 'testersR0ck!'
test_username = 'Karen Tobo'
expected_accounts = 0

# open a browser
browser = Watir::Browser.new

# print some comments
puts "Beginning of test: Recurly account list"

puts " Step 1: go to the login page: " + test_site
browser.goto test_site

puts " Step 2: enter #{test_email} in the email field"
t = browser.text_field(:id => 'user_email')
t.exists?
t.set test_email

puts " Step 3: enter #{test_password} in the email field"
t = browser.text_field(:id => 'user_password')
t.exists?
t.set test_password

puts " Step 4: click the Log In button"
browser.button(:id => 'submit_button').click

puts "  Verify we are on https://#{test_subdomain}.recurly.com"
browser.url.include? "https://#{test_subdomain}.recurly.com"

puts "  Verify user name #{test_username} appears on page"
browser.text.include? test_username

puts " Step 5: click the Accounts navigation link"
l = browser.link(:text => 'Accounts')
l.exists?
l.click

puts "  Verify we are on accounts page"
if (browser.url == "https://#{test_subdomain}.recurly.com/accounts")
	puts "  URL is as expected: https://#{test_subdomain}.recurly.com/accounts"
else
	puts "  URL is not as expected, actual URL: " + browser.url
end

puts "  Verify the number of accounts is #{expected_accounts}"
browser.text.include? 'Displaying all #{expected_accounts} accounts'

puts "End of test: Recurly account list"
browser.close	
