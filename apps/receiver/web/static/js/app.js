import "phoenix_html"
import Elm from './main'

const div = document.querySelector('#dustbin-landing')
if (div) Elm.Main.embed(div);

