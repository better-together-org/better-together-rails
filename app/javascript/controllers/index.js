// app/javascript/controllers/index.js

import { application } from 'controllers/application'

// Load all host's controllers defined in the import map under controllers/**/*_controller
import { lazyLoadControllersFrom } from 'stimulus-loading'
lazyLoadControllersFrom('controllers', application)

console.log('new to nl controllers index')
