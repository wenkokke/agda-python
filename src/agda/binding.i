%module binding
%{
#include "Binding_stub.h"

void unsafe_hs_init(int argc, char **argv) {
  hs_init(&argc, &argv);
}

void unsafe_hs_exit() {
  hs_exit();
}

char * unsafe_hs_agda_version() {
  return hs_agda_version();
}

int unsafe_hs_agda_main() {
  return hs_agda_main();
}

char * unsafe_hs_agda_mode_version() {
  return hs_agda_mode_version();
}

int unsafe_hs_agda_mode_main() {
  return hs_agda_mode_main();
}
%}

%typemap(in) (int argc, char **argv) {
  /* Check if is a list */
  if (PyList_Check($input)) {
    int i;
    $1 = PyList_Size($input);
    $2 = (char **) malloc(($1+1)*sizeof(char *));
    for (i = 0; i < $1; i++) {
      PyObject *o = PyList_GetItem($input, i);
      if (PyUnicode_Check(o)) {
        $2[i] = (char *) PyUnicode_AsUTF8AndSize(o, 0);
      } else {
        PyErr_SetString(PyExc_TypeError, "list must contain strings");
        SWIG_fail;
      }
    }
    $2[i] = 0;
  } else {
    PyErr_SetString(PyExc_TypeError, "not a list");
    SWIG_fail;
  }
}

%typemap(freearg) (int argc, char **argv) {
  free((char *) $2);
}

void unsafe_hs_init(int argc, char **argv);
void unsafe_hs_exit();

char * unsafe_hs_agda_version();
int unsafe_hs_agda_main();

char * unsafe_hs_agda_mode_version();
int unsafe_hs_agda_mode_main();