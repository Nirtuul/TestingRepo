using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.Rendering;
[RequireComponent(typeof(Rigidbody2D))]
[RequireComponent(typeof(BoxCollider2D))]
public class PlayerSquash : MonoBehaviour
{
    private GameObject _playerObj;
    private Rigidbody2D _rigidbody;
    private Renderer rend;
    private float maxStretch = 1.5f;
    private  Vector4 SquashVector = Vector4.one;
    [Range(0,200)] int time = 0;

    private void Awake()
    {
        _playerObj = GameObject.FindWithTag("Player");
        _rigidbody = _playerObj.GetComponent<Rigidbody2D>();
        rend = GetComponent<Renderer>();
        rend.material = new Material(Shader.Find("Hidden/NewImageEffectShader"));
        rend.material.shader = Shader.Find("Hidden/NewImageEffectShader");
    }

    private void OnCollisionEnter2D(Collision2D other)
    {
        if (other.collider.CompareTag("Ground"))
        {
            Vector4 SquashVector = Vector4.one;
            time = 100;
            rend.material.SetVector("_SquashValue", SquashVector);
            rend.material.SetFloat("_TimeElapsed", time);
        }
    }

    private float GetSquashValueX(Vector2 moveVector)
    {
        float magnitude = moveVector.magnitude;
        return Mathf.Clamp(moveVector.x * magnitude, -maxStretch, maxStretch);
    }

    private float GetSquashValueY(Vector2 moveVector)
    {
        float magnitude = moveVector.magnitude;
        return Mathf.Abs(Mathf.Clamp(moveVector.y * magnitude, 1.0f, maxStretch));
    }

    private void SetShaderDataX(Vector2 direction)
    {
        SquashVector = new Vector4(GetSquashValueX(direction),1.0f,1.0f , 1.0f);
        rend.material.SetVector("_SquashValue", SquashVector);
    }

    private void SetShaderDataY(Vector2 direction)
    {
        SquashVector = new Vector4(1.0f, GetSquashValueY(direction), 1.0f, 1.0f);
        rend.material.SetVector("_SquashValue", SquashVector);
    }

    private void ResetShaderData()
    {
        rend.material.SetVector("_SquashValue", Vector4.one);
        rend.material.SetFloat("_TimeElapsed", time);
    }
    
    void Update()
    {
        if (Mathf.Abs(_rigidbody.velocity.x)>Double.Epsilon )// to be replaced by _rigidbody.velocity.x>0
        {
            time = 100;
            Debug.Log("Hello!");
            SetShaderDataX(_rigidbody.velocity);
        }
        else if (Input.GetKey(KeyCode.LeftArrow))// to be replaced by _rigidbody.velocity.x<0
        {
            time = 100;
            SetShaderDataX(_rigidbody.velocity);
        }
        else if (Input.GetKey(KeyCode.UpArrow))// to be replaced by _rigidbody.velocity.y>0
        {
            time = 100;
            SetShaderDataY(_rigidbody.velocity);
        }
        if (_rigidbody.velocity == Vector2.zero)
        {
            time = 100;
            ResetShaderData();
        }
        time+=1;
        rend.material.SetFloat("_TimeElapsed", time);
    }
}
