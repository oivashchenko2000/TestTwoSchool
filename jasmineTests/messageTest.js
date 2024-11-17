describe('c:messageExample', function () {
	it('verify data binding', function (done) {
		$T.createComponent('c:messageExample', {msg: 'Beard gang'}, true)
			.then(function (component) {
				expect(component.find("msg").getElement().innerHTML).toBe('Beard gang');
				expect(component.find("messageInput").get("v.value")).toBe('Beard gang');
				done();
			}).catch(function (e) {
			done.fail(e);
		});
	});
});