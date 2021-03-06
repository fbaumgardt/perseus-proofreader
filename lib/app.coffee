express = require('express')

index = require('./routes/index')
work = require('./routes/work')
page = require('./routes/page')
image = require('./routes/image')
conversions = require('./routes/conversions')
commit = require('./routes/commit')

app = express()
app.use(express.responseTime())
app.use(express.bodyParser())
app.use(express.methodOverride())
app.use(express.compress())
app.use(express.static('./lib/public'))
app.set('view engine', 'ejs')
app.set('views', './lib/views')

app.use((err, req, res, next) ->
  console.error(err.stack)
  res.send(500)
)

app.get('/',                    [ index.load ],
  index.show)
app.get('/:work',               [ index.load, work.load ],
  work.show)
app.get('/:work/:page',         [ index.load, work.load, page.load ],
  page.show)
app.get('/:work/:page/img',     [ index.load, image.load ],
  image.show)
app.post('/:work/:page',        [ index.load, conversions.do ],
  commit.write)

module.exports = app