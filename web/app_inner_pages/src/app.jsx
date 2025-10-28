import { Router, Route } from 'preact-router';
import { createHashHistory } from 'history';

import Page1 from './page1.jsx';
import Page2 from './page2.jsx';

export function App() {
  return (
    <Router history={createHashHistory()}>
      <Route path="/" component={Page1} />
      <Route path="/page2" component={Page2} />
    </Router>
  )
}
