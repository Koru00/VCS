use pyo3::prelude::*;
use pyo3::types::PyModule;
use std::fs;

fn main() -> PyResult<()> {
    // Carica il contenuto del file Python
    let code = fs::read_to_string("../../python/main.py")
        .expect("Impossibile leggere main.py");

    // Esegui Python
    Python::with_gil(|py| {
        // Crea un modulo temporaneo dove eseguire il codice
        let module = PyModule::from_code(py, &code, "main.py", "main")?;
        println!("Python eseguito con successo.");
        Ok(())
    })
}
