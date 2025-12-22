use pyo3::prelude::*;
use pyo3::types::PyModule;
use std::fs;

#[unsafe(no_mangle)]
extern "C" fn mainPY() {
    let code = fs::read_to_string("main.py").expect("Error");

    Python::with_gil(|py| {
        let module = PyModule::from_code(py, &code, "main.py", "main");
        println!("Python running");
    });
}