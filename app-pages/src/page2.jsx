import './app.scss'
import { route } from 'preact-router';

export default function Page2() {
    return <div class="content">
        <div class="title">
            这是页面2
        </div>

        <button onClick={() => {
            route('/');
        }}>跳转到页面1</button>

    </div >
}