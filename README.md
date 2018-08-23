# ReadAllLibrary

This is my solution to City of Glasgow College's HND Software Development Year 2
Graded Unit.

---

## Installation

This project was written in Ruby 2.4, and Rails 5.1.6.

To install through the command line, clone the repository with the link below:

**SSH**

`$ git clone git@github.com:stephanhorvath/ReadAllLibrary.git`

**HTTPS**

`$ git clone https://github.com/stephanhorvath/ReadAllLibrary.git`

**IMPORTANT:** after cloning, make sure to seed the database with:

`$ rails db:reset db:seed`

---

## Instructions

### To Log In as a Manager

1. Click 'Log In' on the header.
2. Enter the email: stephan@readall.com
3. Enter the password: password
4. Click 'Log In' button.

---

### Manager Book Actions

Managers can add, update, and delete books.

#### To Add a New Book

1. Click 'Browse' on the header.
2. Scroll to the bottom of the page.
3. Click on 'New Book'
4. Enter new book details.
5. Type should be "Book". This is in the form as future expansion could allow
different types of book. (Paperback, Hardback, Audiobook)

#### To Edit an Existing Book

1. Click on 'Browse' if not already on the browse page.
2. Click on 'Edit Book'
3. Change the details that need updating.
4. Click on 'Update Book'.

#### To Delete a Book

1. Click on 'Browse' if not already on the browse page.
2. Click on 'Delete'.
3. Click on 'OK' to confirm deletion.

---

### Manager Loan Actions

Managers can view all loans, mark loans as returned, and cancel loans.

#### To View a List of All Loans

1. Click on 'All Loans' in the header.

#### To View Individual Loan Details

1. Click on 'All Loans' in the header.
2. Click on the specific loan's 'Review' link.

#### To Mark a Loan as Returned

1. Click on 'All Loans' in the header.
2. Click on the specifc loan's 'Edit' link.
3. Check the 'Returned?' checkbox.
4. Click on 'Confirm Return'.

#### To Cancel a Loan

1. Click on 'All Loans' in the header.
2. If the loan is not returned, click on 'Review'
3. Click on 'Cancel Loan'
4. Click on 'OK' to confirm cancellation.

---

### Manager Member Actions

Managers can view all members, edit member details, and delete members.

#### To View a List of All Members

1. Click on 'All Members' in the header.

#### To View Individual Member Details

1. Click on 'All Members' in the header.
2. Click on the specific member's 'Show' link.

#### To Update a Member's Details

1. Click on 'All Members' in the header.
2. Click on specific member's 'Edit' link.
3. Change details.
4. Assign new password. Make sure password confirmation matches.
5. Click on 'Update Details' to save changes.

**IMPORTANT:**

Member subscriptions can only be changed through Stripe.

Members can only be fined through Stripe.

---

### To Register as a Member

1. Click 'Register' on the home page. Alternatively, click 'Sign up now!' on the
   'Log In' page.
2. Select a subscription. At the moment of writing, only 'Unlimited Paperback'
   subscriptions are implemented.
3. Fill out registration form.
4. Click 'Subscribe'.
5. Fill out payment form with the following details:
    * Email: email used in registration form.
    * Card Number: 4242 4242 4242 4242
    * Expiry Date: any date in the future, e.g. 02/30.
    * CVV: any three number digit, e.g. 123.
6. Click 'Subscribe'.
7. You will be automatically logged in.

### To Log In as a Member

1. Click 'Log In' on the header.
2. Enter the email: james@readall.com
3. Enter the password: password
4. Click 'Log In' button.

#### Adding Books to a Loan Order

1. Click 'Browse'
2. Books that have a white background are in stock. Books with a yellow
   background are not in stock and have a 'Not in Stock' message.
3. Click 'Add to Loan' on one book.
4. The page will be refreshed and the header will be updated to reflect the
   amount of books in the cart, i.e. 1.
5. If you want, add another book to the cart.

#### Removing Books from a Loan Order

1. Click '# Books in Cart' in the header.
2. Click the 'X' next to the book you wish to remove.

#### Confirming a Loan Order

1. Click the cart message in the header.
2. Review the begin date and the end date of the loan.
3. Review the books you have added to the cart.
4. Click 'Confirm Loan' to confirm.

#### Cancelling a Loan Order

1. Once a loan has been confirmed, you will be taken to that loan's detailed
   view.
2. You can either click the red 'Cancel Loan' button, and click 'OK' to confirm.
3. Or go to your member profile by clicking the dropdown in the header, and
   clicking 'Profile'.
4. Scroll down to the last loan, i.e. the lastest one.
5. Click 'View'.
6. Click 'Cancel Loan' button, and click 'OK' to confirm.
