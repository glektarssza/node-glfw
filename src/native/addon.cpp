/**
 * @file src/native/addon.cpp
 * @author G'lek Tarssza
 * @copyright Copyright (c) 2024 G'lek Tarssza
 * @copyright Licensed under the MIT License.
 */

//-- NodeJS
#include <node.h>
#include <node_api.h>

namespace node_glfw {
    void helloWorld(const v8::FunctionCallbackInfo<v8::Value>& info) {
        auto isolate = info.GetIsolate();
        auto context = isolate->GetCurrentContext();
        info.GetReturnValue().Set(
            v8::String::NewFromUtf8Literal(isolate, "Hello world!"));
    }

    /**
     * Register the Node native addon.
     *
     * @param exports The JavaScript object that represents the exported
     * functions.
     * @param module The JavaScript object that represents the module.
     */
    void registerModule(v8::Local<v8::Object> exports,
                        v8::Local<v8::Object> module) {
        auto isolate = v8::Isolate::GetCurrent();
        auto context = isolate->GetCurrentContext();
        exports->DefineOwnProperty(
            context, v8::String::NewFromUtf8Literal(isolate, "helloWorld"),
            v8::Function::New(context, helloWorld).ToLocalChecked());
    }
} // namespace node_glfw

NODE_MODULE(node_glfw, node_glfw::registerModule)
