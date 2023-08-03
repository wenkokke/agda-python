def test_agda_version() -> None:
    import agda

    assert agda.version() == agda.VERSION
