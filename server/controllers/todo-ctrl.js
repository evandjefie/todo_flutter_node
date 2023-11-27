const Todo = require('../models/todo-model')
const bd = [
    
]

createTodo = (req, res) => {
    const body = req.body

    if (!body) {
        return res.status(400).json({
            success: false,
            error: 'You must provide a Todo',
        })
    }

    const todo = new Todo(body)

    if (!todo) {
        return res.status(400).json({ success: false, error: err })
    }

    // todo
    //     .save()
    //     .then(() => {
    //         return res.status(201).json({
    //             success: true,
    //             id: todo._id,
    //             message: 'Todo created!',
    //         })
    //     })
    //     .catch(error => {
    //         return res.status(400).json({
    //             error,
    //             message: 'Todo not created!',
    //         })
    //     })

    
    bd.push(todo)
    todoIndex = bd.indexOf(todo)
    if (todoIndex) {
        return res.status(201).json({
            success: true,
            id: todoIndex,
            message: 'Todo created!',
        })
    }else{
        return res.status(400).json({
            error,
            message: 'Todo not created!',
        })
    }

}

updateTodo = async (req, res) => {
    const body = req.body

    if (!body) {
        return res.status(400).json({
            success: false,
            error: 'You must provide a body to update',
        })
    }

    Todo.findOne({ _id: req.params.id }, (err, todo) => {
        if (err) {
            return res.status(404).json({
                err,
                message: 'Todo not found!',
            })
        }
        todo.title = body.title
        todo.description = body.description
        todo.completed = "false"
        todo
            .save()
            .then(() => {
                return res.status(200).json({
                    success: true,
                    id: todo._id,
                    message: 'Todo updated!',
                })
            })
            .catch(error => {
                return res.status(404).json({
                    error,
                    message: 'Todo not updated!',
                })
            })
    })
}

deleteTodo = async (req, res) => {
    await Todo.findOneAndDelete({ _id: req.params.id }, (err, todo) => {
        if (err) {
            return res.status(400).json({ success: false, error: err })
        }

        if (!todo) {
            return res
                .status(404)
                .json({ success: false, error: `Todo not found` })
        }

        return res.status(200).json({ success: true, data: todo })
    }).catch(err => console.log(err))
}

getTodoById = async (req, res) => {
    await Todo.findOne({ _id: req.params.id }, (err, todo) => {
        if (err) {
            return res.status(400).json({ success: false, error: err })
        }

        if (!todo) {
            return res
                .status(404)
                .json({ success: false, error: `Todo not found` })
        }
        return res.status(200).json({ success: true, data: todo })
    }).catch(err => console.log(err))
}

getTodos = async (req, res) => {
    // await Todo.find({}, (err, todos) => {
    //     if (err) {
    //         return res.status(400).json({ success: false, error: err })
    //     }
    //     if (!todos.length) {
    //         return res
    //             .status(404)
    //             .json({ success: false, error: `Todo not found` })
    //     }
    //     return res.status(200).json({ success: true, data: todos })
    // }).catch(err => console.log(err))

    
    // await bd.find({}, (err, todos) => {
    //     if (err) {
    //         return res.status(400).json({ success: false, error: err })
    //     }
    //     if (!todos.length) {
    //         return res
    //             .status(404)
    //             .json({ success: false, error: `Todo not found` })
    //     }
    //     return res.status(200).json({ success: true, data: todos })
    // }).catch(err => console.log(err))

    if (bd.length) {
        return res.status(200).json({ success: true, data: bd })        
    }else{
        return res.status(404).json({ success: false, error: `Todo not found` })
    }

}

module.exports = {
    createTodo,
    updateTodo,
    deleteTodo,
    getTodos,
    getTodoById,
}