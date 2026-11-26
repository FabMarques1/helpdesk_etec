// Interface demonstrativa: não envia nem armazena credenciais.
const form = document.querySelector('#login-form, #register-form');
const isRegister = form.id === 'register-form';
const email = document.querySelector('#email');
const password = document.querySelector('#password');
const firstName = document.querySelector('#first-name');
const lastName = document.querySelector('#last-name');
const toggle = document.querySelector('#toggle-password');
const submit = document.querySelector('#submit');
const status = document.querySelector('#status');
const submitLabel = document.querySelector('#submit-label');
const spinner = submit.querySelector('.spinner');
const fields = isRegister ? [firstName, lastName, email, password] : [email, password];

function error(input, message = '') {
    input.setAttribute('aria-invalid', String(Boolean(message)));
    document.querySelector(`#${input.id}-error`).textContent = message;
}

function validate(input) {
    const value = input.value;
    if (input === firstName) {
        return value.trim() ? '' : 'Informe seu nome.';
    }
    if (input === lastName) {
        if (!value.trim()) return 'Informe seu último nome.';
        return /\s/u.test(value) ? 'Digite apenas o último nome, sem espaços.' : '';
    }
    if (input === email) {
        if (!value.trim()) return 'Informe seu e-mail.';
        return input.validity.valid ? '' : 'Digite um e-mail válido.';
    }
    if (!value) return 'Informe sua senha.';
    if (isRegister && value.length < 8) return 'A senha deve ter pelo menos 8 caracteres.';
    return '';
}

toggle.addEventListener('click', () => {
    const visible = password.type === 'password';
    password.type = visible ? 'text' : 'password';
    toggle.setAttribute('aria-pressed', String(visible));
    toggle.setAttribute('aria-label', visible ? 'Ocultar senha' : 'Mostrar senha');
    document.querySelector('#eye-slash').toggleAttribute('hidden', !visible);
});

fields.forEach(input => {
    input.addEventListener('input', () => {
        error(input, input === lastName && /\s/u.test(input.value) ? validate(input) : '');
        status.hidden = true;
    });
    input.addEventListener('blur', () => {
        if (input.value) error(input, validate(input));
    });
});

form.addEventListener('submit', event => {
    event.preventDefault();
    if (submit.disabled) return;
    let firstInvalid = null;
    fields.forEach(input => {
        const message = validate(input);
        error(input, message);
        if (message && !firstInvalid) firstInvalid = input;
    });
    status.hidden = true;
    if (firstInvalid) {
        firstInvalid.focus();
        return;
    }
    submit.disabled = true;
    spinner.hidden = false;
    submitLabel.textContent = isRegister ? 'Validando...' : 'Entrando...';
    setTimeout(() => {
        submit.disabled = false;
        spinner.hidden = true;
        submitLabel.textContent = isRegister ? 'Criar conta' : 'Entrar';
        password.value = '';
        password.type = 'password';
        toggle.setAttribute('aria-pressed', 'false');
        toggle.setAttribute('aria-label', 'Mostrar senha');
        document.querySelector('#eye-slash').setAttribute('hidden', '');
        status.textContent = isRegister
            ? 'Dados validados. Nenhuma conta foi criada: cadastro demonstrativo.'
            : 'Demonstração concluída. A autenticação ainda não está conectada.';
        status.hidden = false;
    }, 650);
});

const dialog = document.querySelector('#info-dialog');
if (dialog) {
    document.querySelector('[data-dialog="recover"]').addEventListener('click', () => {
        document.querySelector('#dialog-title').textContent = 'Recuperar senha';
        document.querySelector('#dialog-text').textContent = 'A recuperação de senha estará disponível quando o sistema de autenticação for integrado.';
        dialog.showModal();
    });
    document.querySelector('#close-dialog').addEventListener('click', () => dialog.close());
}

// Point art: o notebook é desenhado com círculos em Canvas, sem imagem externa.
const canvas = document.querySelector('#laptop');
const ctx = canvas.getContext('2d');
const reduced = matchMedia('(prefers-reduced-motion: reduce)');
const screen = [[220, 60], [490, 32], [443, 281], [165, 253]];
const base = [[165, 253], [443, 281], [305, 367], [18, 310]];
const mix = (a, b, t) => a + (b - a) * t;

function project(q, u, v) {
    return [mix(mix(q[0][0], q[1][0], u), mix(q[3][0], q[2][0], u), v), mix(mix(q[0][1], q[1][1], u), mix(q[3][1], q[2][1], u), v)];
}

function point(x, y, r = 1, opacity = .85) {
    ctx.globalAlpha = opacity;
    ctx.beginPath();
    ctx.arc(x, y, r, 0, Math.PI * 2);
    ctx.fill();
}

function dotLine(a, b, step = 4, r = 1.1, opacity = .82) {
    const count = Math.max(1, Math.ceil(Math.hypot(b[0] - a[0], b[1] - a[1]) / step));
    for (let i = 0; i <= count; i++) {
        point(mix(a[0], b[0], i / count), mix(a[1], b[1], i / count), r, opacity);
    }
}

function outline(q, step = 4, r = 1.1, opacity = .82) {
    q.forEach((p, i) => dotLine(p, q[(i + 1) % q.length], step, r, opacity));
}

function subquad(q, u0, v0, u1, v1) {
    return [project(q, u0, v0), project(q, u1, v0), project(q, u1, v1), project(q, u0, v1)];
}

function draw(time = 0) {
    ctx.setTransform(2, 0, 0, 2, 0, 0);
    ctx.clearRect(0, 0, 520, 420);
    ctx.fillStyle = '#ffffff';
    outline(screen, 3.9, 1.35, .94);
    outline(subquad(screen, .025, .027, .975, .96), 4.6, .85, .60);
    const camera = project(screen, .5, .017);
    point(...camera, 1.5, .9);
    // Onda discreta na tela, construída com uma malha de pontos brancos.
    const inner = subquad(screen, .055, .075, .95, .92);
    for (let i = 0; i <= 49; i++)
        for (let j = 0; j <= 37; j++) {
            const u = i / 49, v = j / 37;
            const ridge = .76 - .43 * u + .10 * Math.sin(u * 5.5 + time * .0007);
            const distance = v - ridge;
            const strength = Math.exp(-Math.pow(distance / .19, 2)) * Math.sin(Math.PI * (.09 + .86 * u));
            if (strength < .055)
                continue;
            const p = project(inner, u, v + .018 * Math.sin(u * 12 + v * 5 + time * .0006));
            point(...p, .35 + strength * .87, .14 + strength * .77);
        }
    // Base, teclado e touchpad em perspectiva.
    outline(base, 3.5, 1.16, .88);
    const lower = base.map(([x, y]) => [x, y + 7]);
    outline(lower, 3.6, 1.0, .70);
    [1, 2, 3].forEach(i => dotLine(base[i], lower[i], 3, 1, .7));
    for (let i = 0; i <= 57; i++)
        for (let j = 0; j <= 22; j++) {
            const u = i / 57, v = j / 22;
            if ((u > .12 && u < .91 && v > .08 && v < .59) || (u > .28 && u < .66 && v > .64 && v < .94))
                continue;
            const p = project(base, u, v);
            point(...p, .52, .3 + (.13 * Math.sin(i * 2 + j)));
        }
    for (let row = 0; row < 6; row++) {
        const n = row === 5 ? 9 : 13;
        for (let col = 0; col < n; col++) {
            const u = .105 + col * .79 / n, v = .085 + row * .084, w = .79 / n * .73, h = .052;
            const key = subquad(base, u, v, u + w, v + h);
            for (let i = 0; i < 4; i++)
                for (let j = 0; j < 3; j++)
                    point(...project(key, i / 3, j / 2), .83, .66 + (row % 2) * .15);
        }
    }
    outline(subquad(base, .30, .64, .66, .93), 3.4, .80, .77);
    dotLine(screen[3], screen[2], 3, 1.08, .8);
    ctx.globalAlpha = 1;
}

let raf = 0;
let previous = 0;

function animate(t) {
    if (t - previous > 32) {
        draw(t);
        previous = t;
    }
    raf = requestAnimationFrame(animate);
}

function updateAnimation() {
    cancelAnimationFrame(raf);
    draw();
    if (!reduced.matches && !document.hidden && canvas.getBoundingClientRect().width > 0) {
        raf = requestAnimationFrame(animate);
    }
}
reduced.addEventListener('change', updateAnimation);
document.addEventListener('visibilitychange', updateAnimation);
window.addEventListener('resize', updateAnimation);
updateAnimation();
