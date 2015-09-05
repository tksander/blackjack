assert = chai.assert
expect = chai.expect

describe 'AppView', ->
  sinon.spy AppView.prototype, 'render'
  appView = null

  beforeEach ->
    appView = new AppView(model: new App())

  describe 'render', ->
    it 'should render when the app redeals', ->
      AppView.prototype.render.reset()
      expect(appView.render).to.not.have.been.called
      appView.model.redeal()
      expect(appView.render).to.have.been.called
    it 'should render on initialization', ->
      expect(appView.render).to.have.been.called