using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.Rendering;

public class Movement : MonoBehaviour
{
    [SerializeField] private float speed = 5;
    private Rigidbody2D _rigidbody;
    private Vector2 _jump = Vector2.up;
    [SerializeField]private int _jumpStrength = 200;
    private void Awake()
    {
        _rigidbody = GetComponent<Rigidbody2D>();
    }
    private void Update()
    {
        
        if (Input.GetKey(KeyCode.RightArrow))
        {
            
            Vector2 moveRight = Vector3.Lerp(Vector3.zero, Vector2.right*speed, 0.8f);
            _rigidbody.AddForce(moveRight);
           
        }
        else if (Input.GetKey(KeyCode.LeftArrow))
        {
            Vector2 moveLeft = Vector3.Lerp(Vector3.zero, Vector2.left*speed, 0.8f);
            _rigidbody.AddForce(moveLeft);
            
        }
        else if (Input.GetKeyDown(KeyCode.UpArrow))
        {
            Vector3 _acceleration = _jump * _jumpStrength;
            _rigidbody.AddForce(_acceleration);
        }
        
    }
}


