const target = document.getElementById('target')
const items = document.getElementById('items')

function post(name, data) {
    fetch(`https://${GetParentResourceName()}/${name}`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8'
        },
        body: JSON.stringify(data || {})
    })
}

function render(options) {
    items.innerHTML = ''

    options.forEach((option, index) => {
        const item = document.createElement('div')
        item.className = 'item'
        item.dataset.index = index + 1

        const icon = document.createElement('span')
        icon.className = 'icon'
        icon.textContent = option.icon || '◆'

        const label = document.createElement('span')
        label.textContent = option.label

        item.appendChild(icon)
        item.appendChild(label)

        item.addEventListener('click', () => {
            post('select', {
                index: item.dataset.index
            })
        })

        items.appendChild(item)
    })
}

window.addEventListener('message', event => {
    const data = event.data

    if (data.action === 'show') {
        render(data.options || [])
        target.classList.remove('hidden')
    }

    if (data.action === 'hide') {
        target.classList.add('hidden')
        items.innerHTML = ''
    }
})

window.addEventListener('keydown', event => {
    if (event.key === 'Escape') {
        post('close')
    }
})
