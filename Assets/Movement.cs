using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class Movement : MonoBehaviour
{
    [SerializeField] private InputActionAsset _inputActionAsset;

    private InputAction Left;

    private InputAction Right;

    [SerializeField] private float speed = 10;

    private GameObject square;

    private Rigidbody2D _rigidbody;

    private Vector2 _jump;

    [SerializeField]private int _jumpStrength = 10;

    [SerializeField]private Shader _fishyShader;

    private Renderer rend;
    // Start is called before the first frame update
    private void Awake()
    {
        Left = _inputActionAsset.FindAction("Left");
        Right = _inputActionAsset.FindAction("Right");
        square = GameObject.Find("Control");
        _rigidbody = square.GetComponent<Rigidbody2D>();
        _jump = Vector2.up;
        rend = GetComponent<Renderer>();
    }

    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKey(KeyCode.RightArrow))
        {
            Debug.Log("Right");
            square.transform.position += new Vector3(speed*Time.deltaTime,0,0);
            
        }
        else if (Input.GetKey(KeyCode.LeftArrow))
        {
            square.transform.position += new Vector3(-speed*Time.deltaTime,0,0);
        }
        else if (Input.GetKeyDown(KeyCode.UpArrow))
        {
            _rigidbody.AddForce(_jump*_jumpStrength);
            rend.material.SetFloat("_ForceAppliedY", _jump.y*100);
            Debug.Log(rend.material.shader.GetPropertyName(4));
        }
    }
}
