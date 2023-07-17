<?php

namespace App\Http\Controllers;

class ContentController extends Controller
{
    public function index()
    {
        return ([
            'content-1' => 'Branch rb-1 This is content 1',
            'content-2' => 'Branch rb-1 This is content 2',
            'content-3' => 'Branch rb-1 This is content 3',
            'content-4' => 'Branch rb-1 This is content 4',
            'content-5' => 'Branch rb-1 This is content 5',
            'content-6' => 'Branch rb-1 This is content 6',
        ]);
    }
}
