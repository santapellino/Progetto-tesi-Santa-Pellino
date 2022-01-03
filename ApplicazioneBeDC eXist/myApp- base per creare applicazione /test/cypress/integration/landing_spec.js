/* global cy */
describe('The landing page', function () {
  it('should load ', function () {
    cy.visit('/exist/yes/BDC/index.html')
      .get('.alert')
      .contains('app.xql')
  })

})
