import * as riot from 'riot'
import * as redux from 'redux'
import './tags/bars-section.tag'
import './tags/footer-section.tag'
import './tags/menu-section.tag'
import './tags/rg-map.tag'
import '../styles/main.sass'
import data from '../shared/data'

const req = require.context("../shared/icons", true, /\.svg$|.png$/)
req.keys().forEach( (key) => {
    req(key)
})


let sharedObservable = riot.observable()

let reducer = function(state = {}, action) {
    switch(action.type) {
      case 'CHANGE_PLACE':
        let newState = data.filter((el) => el.category === action.key)
        return newState
      default:
        return state
    }
}

let reduxStore = redux.createStore(reducer)

document.addEventListener('DOMContentLoaded', () => {
  riot.mount('*', {store:reduxStore, observable: sharedObservable, data})
})
