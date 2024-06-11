#ifndef OVERRIDES_H
#define OVERRIDES_H

#include "imgui_internal.h"
#include "imgui_te_engine.h"
#include "jlcxx/array.hpp"

inline void* TestFunc(ImGuiTest* test) {
    return reinterpret_cast<void*>(test->TestFunc);
}

inline void* set_TestFunc(ImGuiTest* test, void* func) {
    test->TestFunc = reinterpret_cast<ImGuiTestTestFunc*>(func);
    return func;
}

inline void* GuiFunc(ImGuiTest* test) {
    return reinterpret_cast<void*>(test->GuiFunc);
}

inline void* set_GuiFunc(ImGuiTest* test, void* func) {
    test->GuiFunc = reinterpret_cast<ImGuiTestGuiFunc*>(func);
    return func;
}

inline ImGuiContext* Ptr2ImGuiContext(void* ctx) {
    return static_cast<ImGuiContext*>(ctx);
}

inline void* GetWindowByRef(ImGuiTestContext* ctx, ImGuiTestRef ref) {
    return static_cast<void*>(ctx->GetWindowByRef(ref));
}

inline void SetRef(ImGuiTestContext* ctx, void* window) {
    ctx->SetRef(static_cast<ImGuiWindow*>(window));
}

inline void ScrollToTabItem(ImGuiTestContext* ctx, void* tab_bar, ImGuiID tab_id) {
    ctx->ScrollToTabItem(static_cast<ImGuiTabBar*>(tab_bar), tab_id);
}

inline bool TabBarCompareOrder(ImGuiTestContext* ctx, void* tab_bar, const char** tab_order) {
    return ctx->TabBarCompareOrder(static_cast<ImGuiTabBar*>(tab_bar), tab_order);
}

inline jlcxx::Array<ImGuiTest*> TestsAll(ImGuiTestEngine* engine) {
    auto size{ engine->TestsAll.size() };
    jlcxx::Array<ImGuiTest*> tests{ static_cast<size_t>(size) };

    // jl_array_data() changed in 1.11 so we need to check the Julia version
    // we're building against.
    #if JULIA_VERSION_MAJOR == 1 && JULIA_VERSION_MINOR < 11
    ImGuiTest** data_ptr{ (ImGuiTest**)jl_array_data(tests.wrapped()) };
    #else
    ImGuiTest** data_ptr{ jl_array_data(tests.wrapped(), ImGuiTest*) };
    #endif

    for (int i = 0; i < size; ++i) {
        data_ptr[i] = engine->TestsAll[i];
    }

    return tests;
}

#endif
